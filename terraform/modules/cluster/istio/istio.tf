resource helm_release istio {
  count         = "${local.istio["deploy"]}"
  namespace     = "${local.namespace}"
  repository    = "${var.repository["istio.io"]}"
  name          = "${local.istio["name"]}"
  version       = "${local.istio["version"]}"
  chart         = "${local.istio["chart"]}"
  force_update  = "${local.istio["force_update"]}"
  wait          = "${local.istio["wait"]}"
  recreate_pods = "${local.istio["recreate_pods"]}"

  # TODO: create for tracing and kiali secrets
  values = [<<EOF
pilot:
  enabled: true
  sidecar: true
gateways:
  enabled: false
security:
  enabled: true
sidecarInjectorWebhook:
  enabled: false
galley:
  enabled: false
mixer:
  policy:
    enabled: false
  telemetry:
    enabled: false
tracing:
  enabled: true
  provider: zipkin
kiali:
  enabled: true
  dashboard:
    auth:
      trategy: login # anonymous
prometheus:
  enabled: false
global:
  proxy:
    tracer: "zipkin"
  controlPlaneSecurityEnabled: true
  mtls:
    # Default setting for service-to-service mtls. Can be set explicitly using
    # destination rules or service annotations.
    enabled: true
  proxy:
    envoyStatsd:
      enabled: false
      host: # example: statsd-svc.istio-system
      port: # example: 9125
  useMCP: false
EOF
  ]

  depends_on = [
    "kubernetes_namespace.this",
    "kubernetes_secret.kiali",
  ]
}
