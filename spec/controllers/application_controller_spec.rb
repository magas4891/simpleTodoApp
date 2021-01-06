require 'rails_helper'

RSpec.describe ApplicationController do
  controller do
    def after_sign_in_path_for(resource)
      super resource
    end

    def after_sign_out_path_for(resource)
      super resource
    end
  end

  let(:user) { create(:user) }

  it { expect(controller.after_sign_out_path_for(user)).to eq(root_path) }
  it { expect(controller.after_sign_in_path_for(user)).to eq(projects_path) }
end
