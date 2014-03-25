module ValidationsHelper
  def validate_inclusion_of(key, list)
    if !list.include?(key)
      halt 400, { "error" => "#{key} is expected to be one of #{list.inspect}." }.to_json
    end
  end
end
