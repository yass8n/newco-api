require "net/http"
require "uri"
module GlobalConstants
  # notice the call to 'freeze'
  # API_KEY = "75e5c2ec2322053c2a8b7b67e309dfc6".freeze
  # SCHED_URI = URI.parse("http://newcolosangeles2015.sched.org")
  # FILTER_TYPE = "location"
  # # API_KEY = "08d2f1d3e2dfe3a420b228ad73413cb7".freeze
  # # SCHED_URI = URI.parse("http://newcobaybridgefestivals2015.sched.org")
  # HTTP = Net::HTTP.new(SCHED_URI.host, SCHED_URI.port)
  S3_URL = "https://s3.amazonaws.com/newco-festivals-bucket/".freeze
  S3_YASEEN_URL = "https://s3.amazonaws.com/newco-iframe-bucket/".freeze
  LOGO = S3_URL + "assets/images/newco-logo.png".freeze
end