require 'rest-client'
require 'uri'
require 'nokogiri'
require 'json'

#기본 url
url = "https://api.telegram.org/bot"
#tokern을 통해서 우리의 chatbot을 확인하고,
token = "500134663:AAFv7ILQJY-TeIqLkoOaWaFcf09gl7eX-Kg"
#getUpdates method활용
get_id_url = "#{url}#{token}/getUpdates"
#get 요청을 보냄
#응답은 json 형식으로 넘어온다
response = RestClient.get(get_id_url)
#RUBY의 HASH data type으로 변형
hash = JSON.parse(response)
#id를 가져온다.
puts hash
chat_id = hash["result"][0]["message"]["from"]["id"]

#res_lotto = RestClient.get("http://www.nlotto.co.kr/common.do?method=getlottoNumber&")
msg="안녕,"
msg_url = "#{url}#{token}/sendMessage?chat_id=#{chat_id}&text=#{msg}"
puts msg_url
RestClient.get(URI.encode(msg_url))
