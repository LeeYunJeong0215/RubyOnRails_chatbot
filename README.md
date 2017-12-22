####챗봇

1.  핸드폰에 telegram 다운

2.  BotFather에서 가입 (/start -> /newbot )

3. telegram.rb 소스 작성

   ```ruby
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
   ```

   참고 : telegram bot api : https://core.telegram.org/bots/api



#### 서버에 사이트 올리기

1. Heroku : https://www.heroku.com/home 가입
2. https://devcenter.heroku.com/articles/heroku-cli에서 [Debian/Ubuntu]에 있는 명령어 입력

```console
$ wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh
```

3. Gemfile 추가

   ```ruby
   1. nokogiri, rest-client 추가
   gem 'nokogiri'
   gem 'rest-client'

   2. gem 'sqlite3'를 복사 하고 지운후 

   3. group :development, :test do 내에 복붙
     # Call 'byebug' anywhere in the code to stop execution and get a debugger console
     gem 'byebug'
     gem 'sqlite3'
   end

   4. 맨 아래 아래 코드 추가
   group :production do
     gem 'rails_12factor'
     gem 'pg'
   endvagrant의 해당경로에서 console창에 입력
   ```

4.  vagrant내의 해당경로에서 console창에 입력

   ```console
   1. git에 추가하기 
   $ git init 
   $ git add . 
   $ git commit -m "heroku" 

   2. heroku에 올리기 
   $ heroku create 
   $ git push heroku master
   ```

5. heroku 로그인 ->  dashboard -> More의 Run console

   rake db:migrate 입력

​       참고 : https://devcenter.heroku.com/articles/getting-started-with-ruby#introduction

6. 신용카드 등록 후 dashboard->confiure Add-ons에 -> heroku Scheduler 추가해서 설정하면

   telegram으로 자신이 정한 시간 단위만큼(예를 들면, 1시간에 한번씩) 원하는 정보(ex)코스피지수)를 알릴 수 있게 할 수 있다.