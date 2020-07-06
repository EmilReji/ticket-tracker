=begin

require 'spec_helper'

describe Project do
  it 'saves itself' do
    project = Project.new(name: "Test project 1", description: "Test project 1 description")
    project.save

    Project.first.name.should == "Test project 1"
  end
end
=end

require 'spec_helper'
require "rails_helper"

RSpec.describe Project, type: :model  do
  it "save itself" do
    project = Project.new(name: "Test project 1", description: "Test project 1 description")
    project.save

    expect("Test project 1").to match(Project.first.name)
  end
end

