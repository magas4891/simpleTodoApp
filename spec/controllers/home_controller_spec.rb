require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:send_request) { get :index }

  before { send_request }

  it { is_expected.to respond_with :ok }
end
