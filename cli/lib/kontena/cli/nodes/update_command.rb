module Kontena::Cli::Nodes
  class UpdateCommand < Clamp::Command
    include Kontena::Cli::Common

    parameter "NODE_ID", "Node id"
    option ["-l", "--label"], "LABEL", "Node label", multivalued: true

    def execute
      require_api_url
      require_current_grid
      token = require_token

      data = {}
      data[:labels] = label_list if label_list
      client(token).put("grids/#{current_grid}/nodes/#{node_id}", data)
    end
  end
end
