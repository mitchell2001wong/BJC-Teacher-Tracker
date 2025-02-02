# frozen_string_literal: true

require "rails_helper"

RSpec.describe TeachersController, type: :controller do
  fixtures :all

  it "does not allow non-admin to accept a user" do
    post :validate, {
        params: {
            id: 1
        }
    }
    expect(response).to have_http_status(302)
    expect(response).to redirect_to(root_path)
    expect(flash[:danger]).to eq "You need to log in to access this."
  end

  it "rejects malicious admin signup attempt" do
    post :create, {
        params: {
            school: {
                name: "valid_example",
                city: "Berkeley",
                state: "CA",
                website: "valid_example.com"
            },
            teacher: {
                first_name: "valid_example",
                last_name: "valid_example",
                email: "valid_example@valid_example.edu",
                status: 0,
                snap: "valid_example",
                admin: true
            }
        }
    }
    expect(Teacher.where(email: "valid_example@valid_example.edu").first.admin).to be(false)
  end

  it "rejects malicious auto-approve signup attempt" do
    post :create, {
        params: {
            school: {
                name: "valid_example",
                city: "Berkeley",
                state: "CA",
                website: "valid_example.com"
            },
            teacher: {
                first_name: "valid_example",
                last_name: "valid_example",
                email: "valid_example@valid_example.edu",
                status: 0,
                application_status: "validated",
                snap: "valid_example"
            }
        }
    }
    expect(Teacher.where(email: "valid_example@valid_example.edu").first.application_status).to eq("pending")
  end
end
