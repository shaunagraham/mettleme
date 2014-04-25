## See https://devcenter.heroku.com/articles/searchbox#configuration
#ENV['ELASTICSEARCH_URL'] = ENV['SEARCHBOX_URL']
#
#unless Rails.env.production?
#  # Mock JSON response for Tire (to stop indexing and search in development & test envs)
#  FakeWeb.register_uri(:any, %r(http://localhost:9200/.+), body: '{}')
#end