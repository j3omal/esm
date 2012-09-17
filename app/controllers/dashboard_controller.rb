class DashboardController < ApplicationController

  def index 
    require 'net/http'
    require 'rubygems'
    require 'json'
      
    # settings
    host             = 'prod2.evisions.com'
    port             = 443
    username         = 'esmuser'
    password         = 'esmuser'
    datablock        = 5660
    hash             = '5a2fb8e0701ae1c44c6966698c894278'
    sessionParam     = "sessionid"
    setupSessionURI  = "/mw/Session.Setup?Version=4.0&JSONData={\"Mapplets\":[{\"Guid\":\"B052A35E-DC3B-4283-B732-7BEE3B095C5E\",\"Version\":\"4.0\"}]}"
    authenticateURI  = "/mw/Session.Authenticate?username=#{username}&password=#{password}&#{sessionParam}="
    securityTokenURI = "/mw/Session.SecurityToken.Create?#{sessionParam}="
    uri              = URI("https://prod2.evisions.com") 
     
    def getData(siteURI, httpObject)
      request  = Net::HTTP::Get.new siteURI
      response = httpObject.request request  
      return JSON.parse response.body
    end
     
    Net::HTTP.start(uri.host, uri.port,
      use_ssl: uri.scheme == 'https',
      verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
      
      # set up the session and retrieve the session id
      data = getData(setupSessionURI, http)
      if not data['valid']
        @flash = 'Could not setup session'
        exit
      end
     
      # Get the session and add it to the params of future requests
      session = data['data']['SessionId']
      if session.nil?
        @flash = 'You do not have the latest MAPS service'
        exit
      end
     
      authenticateURI  += session
      securityTokenURI += session
     
      # authenticate the session
      data = getData(authenticateURI, http)
      if not data['valid']
        @flash = 'Could not authenticate session'
        exit
      end
     
      # create the security token
      data = getData(securityTokenURI, http)   
      if not data['valid']
        @flash = 'Could not get token'
        exit
      end
     
      token = data['data']['Token']
      @url = "https://#{host}:#{port}/ArgosWeb/#!DataBlock=#{datablock}&Username=#{username}&Token=#{token}&Hash=#{hash}"
    end    
  end

  def compare 
    require 'net/http'
    require 'rubygems'
    require 'json'
     
        # settings
    host             = 'prod2.evisions.com'
    port             = 443
    username         = 'esmuser'
    password         = 'esmuser'
    datablock        = 5660
    hash             = '5a2fb8e0701ae1c44c6966698c894278'
    sessionParam     = "sessionid"
    setupSessionURI  = "/mw/Session.Setup?Version=4.0&JSONData={\"Mapplets\":[{\"Guid\":\"B052A35E-DC3B-4283-B732-7BEE3B095C5E\",\"Version\":\"4.0\"}]}"
    authenticateURI  = "/mw/Session.Authenticate?username=#{username}&password=#{password}&#{sessionParam}="
    securityTokenURI = "/mw/Session.SecurityToken.Create?#{sessionParam}="
    uri              = URI("https://prod2.evisions.com") 
     
    def getData(siteURI, httpObject)
      request  = Net::HTTP::Get.new siteURI
      response = httpObject.request request  
      return JSON.parse response.body
    end
     
    Net::HTTP.start(uri.host, uri.port,
      use_ssl: uri.scheme == 'https',
      verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
      
      # set up the session and retrieve the session id
      data = getData(setupSessionURI, http)
      if not data['valid']
        @flash = 'Could not setup session'
        exit
      end
     
      # Get the session and add it to the params of future requests
      session = data['data']['SessionId']
      if session.nil?
        @flash = 'You do not have the latest MAPS service'
        exit
      end
     
      authenticateURI  += session
      securityTokenURI += session
     
      # authenticate the session
      data = getData(authenticateURI, http)
      if not data['valid']
        @flash = 'Could not authenticate session'
        exit
      end
     
      # create the security token
      data = getData(securityTokenURI, http)   
      if not data['valid']
        @flash = 'Could not get token'
        exit
      end
     
      token = data['data']['Token']
      @url = "https://#{host}:#{port}/ArgosWeb/#!DataBlock=#{datablock}&Username=#{username}&Token=#{token}&Hash=#{hash}"
    end    
     
    # settings
    host             = 'ec2-50-16-75-184.compute-1.amazonaws.com'
    port             = 80
    username         = 'administrator'
    password         = 'argoS997'
    datablock        = 2
    hash             = '5a2fb8e0701ae1c44c6966698c894278'
    sessionParam     = "sessionid"
    setupSessionURI  = "/mw/Session.Setup?Version=4.0&JSONData={\"Mapplets\":[{\"Guid\":\"B052A35E-DC3B-4283-B732-7BEE3B095C5E\",\"Version\":\"4.0\"}]}"
    authenticateURI  = "/mw/Session.Authenticate?username=#{username}&password=#{password}&#{sessionParam}="
    securityTokenURI = "/mw/Session.SecurityToken.Create?#{sessionParam}="
     
    # make http context
    http = Net::HTTP.new(host, port)
     
    # set up the session and retrieve the session id
    request = Net::HTTP::Get.new(setupSessionURI)
    response = http.request(request)
    data = JSON.parse(response.body)
    if not data['valid']
      @flash = 'Could not setup session'
      exit
    end
     
    # Get the session and add it to the params of future requests
    session = data['data']['SessionId']
    if session.nil?
      @flash = 'You do not have the latest MAPS service'
      exit
    end
    authenticateURI += session
    securityTokenURI += session
     
    # authenticate the session
    request = Net::HTTP::Get.new(authenticateURI)
    response = http.request(request)
    data = JSON.parse(response.body)
    if not data['valid']
      @flash = 'Could not authenticate session'
      exit
    end
     
    # create the security token
    request = Net::HTTP::Get.new(securityTokenURI)
    response = http.request(request)
    data = JSON.parse(response.body)
     
    if not data['valid']
      @flash = "Could not get token"
      exit
    end
    token = data['data']['Token']
    @url2 = "http://#{host}:#{port}/ArgosWeb/#!DataBlock=#{datablock}&Username=#{username}&Token=#{token}&Hash=#{hash}"
  end

  def ec2 
    require 'net/http'
    require 'rubygems'
    require 'json'
     
    # settings
    host             = 'ec2-50-16-75-184.compute-1.amazonaws.com'
    port             = 80
    username         = 'administrator'
    password         = 'argoS997'
    datablock        = 2
    hash             = '5a2fb8e0701ae1c44c6966698c894278'
    sessionParam     = "sessionid"
    setupSessionURI  = "/mw/Session.Setup?Version=4.0&JSONData={\"Mapplets\":[{\"Guid\":\"B052A35E-DC3B-4283-B732-7BEE3B095C5E\",\"Version\":\"4.0\"}]}"
    authenticateURI  = "/mw/Session.Authenticate?username=#{username}&password=#{password}&#{sessionParam}="
    securityTokenURI = "/mw/Session.SecurityToken.Create?#{sessionParam}="
     
    # make http context
    http = Net::HTTP.new(host, port)
     
    # set up the session and retrieve the session id
    request = Net::HTTP::Get.new(setupSessionURI)
    response = http.request(request)
    data = JSON.parse(response.body)
    if not data['valid']
      @flash = 'Could not setup session'
      exit
    end
     
    # Get the session and add it to the params of future requests
    session = data['data']['SessionId']
    if session.nil?
      @flash = 'You do not have the latest MAPS service'
      exit
    end
    authenticateURI += session
    securityTokenURI += session
     
    # authenticate the session
    request = Net::HTTP::Get.new(authenticateURI)
    response = http.request(request)
    data = JSON.parse(response.body)
    if not data['valid']
      @flash = 'Could not authenticate session'
      exit
    end
     
    # create the security token
    request = Net::HTTP::Get.new(securityTokenURI)
    response = http.request(request)
    data = JSON.parse(response.body)
     
    if not data['valid']
      @flash = "Could not get token"
      exit
    end
    token = data['data']['Token']
    @url = "http://#{host}:#{port}/ArgosWeb/#!DataBlock=#{datablock}&Username=#{username}&Token=#{token}&Hash=#{hash}"
  end


end
