require 'spec_helper'
require "rails_helper"

RSpec.describe Project, type: :model  do
  it "CRUD Project" do
    project = Project.new(name: "Test project 1", description: "Test project 1 description")
    project.save
    expect(Project.first.name).to match("Test project 1")

    description = "Test project 1 description edited"
    project.update(description: description)
    expect(Project.first.description).to match(description)

    expect(Project.all.length).to match(1)
    project.destroy
    expect(Project.all.length).to match(0)
  end
end

