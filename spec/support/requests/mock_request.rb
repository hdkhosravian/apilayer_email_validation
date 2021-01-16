module MockRequest
  def mock_requests
    ben_pratt_mock
    b_pratt_mock
    ben_mock
    benpratt_mock
    pratt_ben_mock
  end

  def ben_pratt_mock
    stub_request(:get, "http://apilayer.net/api/check?access_key=90bb9c1e381d6969343824d8fbce8de5&email=ben.pratt@8returns.com").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
      }).
    to_return(status: 200, body: File.read("spec/support/requests/ben.pratt.json"), headers: {"Content-Type"=> "application/json"})
  end

  def b_pratt_mock
    stub_request(:get, "http://apilayer.net/api/check?access_key=90bb9c1e381d6969343824d8fbce8de5&email=b.pratt@8returns.com").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
      }).
    to_return(status: 200, body: File.read("spec/support/requests/b.pratt.json"), headers: {"Content-Type"=> "application/json"})
  end

  def ben_mock
    stub_request(:get, "http://apilayer.net/api/check?access_key=90bb9c1e381d6969343824d8fbce8de5&email=ben@8returns.com").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
      }).
    to_return(status: 200, body: File.read("spec/support/requests/ben.json"), headers: {"Content-Type"=> "application/json"})
  end

  def benpratt_mock
    stub_request(:get, "http://apilayer.net/api/check?access_key=90bb9c1e381d6969343824d8fbce8de5&email=benpratt@8returns.com").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
      }).
    to_return(status: 200, body: File.read("spec/support/requests/benpratt.json"), headers: {"Content-Type"=> "application/json"})
  end

  def pratt_ben_mock
    stub_request(:get, "http://apilayer.net/api/check?access_key=90bb9c1e381d6969343824d8fbce8de5&email=pratt.ben@8returns.com").
    with(
      headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent'=>'Faraday v1.3.0'
      }).
    to_return(status: 200, body: File.read("spec/support/requests/pratt.ben.json"), headers: {"Content-Type"=> "application/json"})
  end
end