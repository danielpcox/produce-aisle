package mesh

import "produce.local/gm"

#all_interfaces: "0.0.0.0"

#default_filters: {
	"gm_metrics": {
		"metrics_dashboard_uri_path":  "/metrics"
		"metrics_host":                "0.0.0.0"
		"metrics_key_depth":           "3"
		"metrics_key_function":        "depth"
		"metrics_port":                39003
		"metrics_prometheus_uri_path": "/prometheus"
		"metrics_receiver": {
			"redis_connection_string": "redis://127.0.0.1:6379"
		}
		"metrics_ring_buffer_size":                   4096
		"prometheus_system_metrics_interval_seconds": 15
	}
}

#EmptySecret: gm.#Secret & {
	"ecdh_curves":            null
	"secret_key":             ""
	"secret_name":            ""
	"secret_validation_name": ""
}

#DefaultZone: "default-zone"

// Domain template with defaults
domains: [Name=_]: gm.#Domain & {
    name: "*"
    domain_key: Name
    zone_key: #DefaultZone
}

// Listeners template w/ defaults
listeners: [Name=_]: gm.#Listener & {
	name:         Name
	listener_key: Name
    domain_keys: [string] | *["\(Name)"]
	#EdgeListenerDefaults
}

// Clusters template w/ defaults
clusters: [Name=_]: gm.#Cluster & {
    name: Name
    cluster_key: Name
    zone_key: #DefaultZone
}

// Constants and shared data

#applePort: 42071
#localhost: "127.0.0.1"

// Set defaults
#EdgeListenerDefaults: gm.#Listener & {
	secret:       #EmptySecret
	zone_key:     #DefaultZone
	http_filters: #default_filters
	protocol:     "http_auto"
	ip:           #all_interfaces
	// Default active filters
	active_http_filters: ["gm.metrics"]
}
