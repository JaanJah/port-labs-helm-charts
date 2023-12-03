{{/*
Expand the name of the chart.
*/}}
{{- define "port-ocean.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "port-ocean.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "port-ocean.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "port-ocean.labels" -}}
helm.sh/chart: {{ include "port-ocean.chart" . }}
{{ include "port-ocean.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "port-ocean.selectorLabels" -}}
app.kubernetes.io/name: {{ include "port-ocean.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Get prefix of ocean resource metadata.name
*/}}
{{- define "port-ocean.metadataNamePrefix" -}}
{{- printf "ocean-%s-%s" .Values.integration.type .Values.integration.identifier }}
{{- end }}

{{/*
Get config map name per integration
*/}}
{{- define "port-ocean.configMapName" -}}
{{ $prefix:= include "port-ocean.metadataNamePrefix" . }}
{{- printf "%s-config" $prefix }}
{{- end }}

{{/*
Get secret name per integration
*/}}
{{- define "port-ocean.secretName" -}}
{{ $prefix:= include "port-ocean.metadataNamePrefix" . }}
{{- default (printf "%s-secret" $prefix) .Values.secret.name }}
{{- end }}

{{/*
Get ingress name per integration
*/}}
{{- define "port-ocean.ingressName" -}}
{{ $prefix:= include "port-ocean.metadataNamePrefix" . }}
{{- printf "%s-ingress" $prefix }}
{{- end }}

{{/*
Get service name per integration
*/}}
{{- define "port-ocean.serviceName" -}}
{{ $prefix:= include "port-ocean.metadataNamePrefix" . }}
{{- printf "%s-service" $prefix }}
{{- end }}

{{/*
Get container name per integration
*/}}
{{- define "port-ocean.containerName" -}}
{{ $prefix:= include "port-ocean.metadataNamePrefix" . }}
{{- printf "%s-container" $prefix }}
{{- end }}

{{/*
Get deployment name per integration
*/}}
{{- define "port-ocean.deploymentName" -}}
{{ $prefix:= include "port-ocean.metadataNamePrefix" . }}
{{- printf "%s-deployment" $prefix }}
{{- end }}

{{/*
Get self signed cert secret name
*/}}
{{- define "port-ocean.selfSignedCertName" -}}
{{ $prefix:= include "port-ocean.metadataNamePrefix" . }}
{{- printf "%s-cert" $prefix }}
{{- end }}