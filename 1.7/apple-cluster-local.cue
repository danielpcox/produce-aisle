package mesh

// Apple

clusters: "apple-local": {
    instances: [ {host: #localhost, port: #appleUpstream}]
}

clusters: apple: {
    instances: [ {host: #localhost, port: #appleSidecar}]
}

domains: apple: port: #appleSidecar