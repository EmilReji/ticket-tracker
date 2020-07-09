require 'spec_helper'
require "rails_helper"

RSpec.describe ProjectsController do
  describe "GET index" do
    it "Sets the @projects variable" do
      project = Project.new(name: "Test project 1", description: "Test project 1 description")
      project.save

      get :index # issue http request for index action on ProjectsController
      #assigns(:projects).should == [] 
      expect(assigns(:projects)).to eq([project]) 
      # can't use to be (uses equal?) since they are different objects
      # to eq uses == which somehow ocmpares data values rather than object identity
    end
    it "Renders the index template" do
      get :index # issue http request for index action on ProjectsController
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe "GET new" do
    it "Sets the @project variable" do
      get :new
      expect(assigns(:project)).to be_new_record
      expect(assigns(:project)).to be_instance_of(Project)
    end
    it "Renders the new template" do 
      get :new
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    it "Creates the project record when the input is valid" do
      post :create, params: { project: { name: "Test project 1", description: "Test project 1 description" } }
      # https://relishapp.com/rspec/rspec-rails/v/4-0/docs/request-specs/request-spec
      expect(Project.first.name).to match("Test project 1")
      expect(Project.first.description).to match("Test project 1 description")

    end
    it "Redirects to the project path when input is valid" do
      post :create, params: { project: { name: "Test project 1", description: "Test project 1 description" } }
      expect(response).to redirect_to project_path(Project.first)   
    end
    it "Doesn't create the project record when input is invalid" do
      post :create, params: { project: { description: "Test project 1 description" } }
      expect(Project.all.length).to match(0)
    end

    it "Renders the new template when input is invalid" do
      post :create, params: { project: { description: "Test project 1 description" } }
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe "PATCH update" do
    #before(:each) do
      #@project = post :create, params: { project: { name: "Test project 1", description: "Test project 1 description" } }
    #end

    it "Update the project record when the input is valid" do
      post :create, params: { project: { name: "Test project 1", description: "Test project 1 description" } }
      patch :update, params: { project: { name: "Edited name", description: "Edited description" } }
      # above patch not working: see notes

      expect(Project.first.name).to match("Edited name")
      expect(Project.first.description).to match("Edited description")
    end
    it "Redirects to project path when input is valid"
    it "Doesn't update the project record when input is invalid"
    it "Renders the edit template when input is invalid"
  end
end
