resource "kubernetes_namespace_v1" "Terra-namespace" {
  metadata {
    annotations = {
      name = "monnamespace"
    }

    labels = {
      usage = "test"
    }

    name = "monnamespace"
  }
}