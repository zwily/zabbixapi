module Zabbix
  class ZabbixApi

    def add_trigger(trigger)
      message = {
          'method' => 'trigger.create',
          'params' => [trigger]
      }
      response = send_request(message)
      response.empty? ? nil : response['triggerids'][0]
    end

    def get_trigger_id(host_id, trigger_name)
      message = {
          'method' => 'trigger.get',
          'params' => {
              'filter' => {
                  'hostid' => host_id,
                  'description' => trigger_name
              }
          }
      }
      response = send_request(message)
      response.empty? ? nil : response[0]['triggerid']
    end

    def get_triggers_by_host(host_id)
      message = {
          'method' => 'trigger.get',
          'params' => {
              'filter' => {
                  'hostid' => host_id,
              },
              'extendoutput' => '1'
          }
      }
      response = send_request(message)
      if response.empty?
        result = {}
      else
        result = {}
        response.each do |trigger|
          trigger_id = trigger['triggerid']
          description = trigger['description']
          result[trigger_id] = description
        end
      end
      return result
    end

    def update_trigger_status(trigger_id, status)
      message = {
          'method' => 'trigger.update_status',
          'params' => {
              'triggerid' => trigger_id,
              'status' => status
          }
      }
      response = send_request(message)
      response.empty? ? nil : response['triggerids'][0]
    end

  end
end
