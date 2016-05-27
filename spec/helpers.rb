module Helpers
  def stub_iron_worker_calls
    queue_task_body = { "msg": "Queued up",
                        "tasks": [{"id": "4eb1b471cddb136065000010"}]
                      }.to_json
    get_task_body = { "id": "4eb1b471cddb136065000010", "status": "complete" }.to_json
    get_task_log_body = "intact -HASHED-> 309f09jads09ds"
    stub_request(:post, /\/projects\/.*\/tasks$/).to_return(body: queue_task_body, status: 201)
    stub_request(:get, /\/projects\/.*\/tasks\/.+$/).to_return(body: get_task_body, status: 200)
    stub_request(:get, /\/projects\/.*\/tasks\/.+\/log$/).to_return(body: get_task_log_body, status: 200)
  end

  def expect_redirect_to(url)
    expect(response).to have_http_status(:redirect)
    expect(response.location).to eql(url)
  end
end
