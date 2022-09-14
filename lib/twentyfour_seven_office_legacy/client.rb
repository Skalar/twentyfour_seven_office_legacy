module TwentyfourSevenOfficeLegacy
  class Client
    attr_accessor :session_id

    def initialize(credential)
      @credential = credential

      auth_client_opts = {
        wsdl: "https://api.24sevenoffice.com/authenticate/v001/authenticate.asmx?wsdl",
        convert_request_keys_to: :camelcase,        
      }

      person_client_opts = {
        wsdl: "https://webservices.24sevenoffice.com/CRM/Contact/PersonService.asmx?WSDL",
        convert_request_keys_to: :camelcase,        
      }

      if ENV["DEBUG_24_SEVEN_OFFICE_SOAP_MESSAGES"] == "true"
        log_opts = { log_level: :debug, log: true }
        auth_client_opts.merge!(log_opts)
        person_client_opts.merge!(log_opts)
      end

      @auth_client = Savon.client(auth_client_opts)
      @person_client = Savon.client(person_client_opts)
    end

    def save_person_item(person_item)
      res = @person_client.call(:save_person, message: person_item.to_hash, cookies: cookies)
      check_result(res)
      res.body[:save_person_response][:save_person_result]
    end

    def save_person_item_request_str(person_item)
      @person_client.operation(:save_person).build(message: person_item.to_hash).to_s
    end

    def find_person_by_id(id)
      res = @person_client.call(:get_persons, message: { "personSearch" => { id: id, get_relation_data: true } }, cookies: cookies)
      check_result(res)
      person_hash = res.body[:get_persons_response][:get_persons_result][:person_item]
      PersonItem.new(person_hash)
    end

    def find_person_by_id_request_str(id)
      @person_client.operation(:get_persons).build(message: { "personSearch" => { id: id } })
    end

    def relations(id)
      res = @person_client.call(:get_relations, message: { "personId" => id }, cookies: cookies)
      check_result(res)
      data = res.body[:get_relations_response][:get_relations_result]
      return [] if data.nil?
      relation_data = data[:relation_data]
      relation_data = Array.try_convert(relation_data) || [relation_data]
      relation_data.map { |rd| RelationData.new(rd) }
    end

    def delete_relation(person_id, company_id)
      @person_client.call(:delete_relation, message: { "personId" => person_id, "companyId" => company_id }, cookies: cookies)
    end

    def make_relation(relation_data)
      @person_client.call(:make_relation, message: relation_data.to_hash, cookies: cookies)
    end

    def has_session?
      return false if @session_id.nil?
      result = @auth_client.call(:has_session, cookies: cookies)
      result.body[:has_session_response][:has_session_result]
    end

    def authenticate
      result = @auth_client.call(:login, message: @credential.to_hash)
      @session_id = result.body[:login_response][:login_result]
      raise AuthenticationError, "login failed" if @session_id.nil?
    end

    private

    def check_result(res)
      if res.http_error?
        raise ApiError, res.http_error
      elsif res.soap_fault?
        raise ApiError, res.soap_fault
      else
        res
      end
    end

    def cookies
      raise AuthenticationError, "session id missing" if @session_id.nil?
      [HTTPI::Cookie.new("ASP.NET_SessionId=#{@session_id}")]
    end
  end
end
