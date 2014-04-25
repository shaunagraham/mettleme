# Mock JSON response for Tire (to stop indexing and search in development & test envs)
FakeWeb.register_uri(:any, %r(http://localhost:9200/.+), body: '{}')