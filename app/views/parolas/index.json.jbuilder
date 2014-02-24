json.array!(@parolas) do |parola|
  json.extract! parola, :id, :input, :output
  json.url parola_url(parola, format: :json)
end
