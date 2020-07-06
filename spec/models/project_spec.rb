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

  it "CRUD Project with Ticket" do
    project = Project.new(name: "Test project 1", description: "Test project 1 description")
    project.save
    ticket = Ticket.new(name: "Test ticket 1", body: "Test ticket 1 under Test project 1", status: "new")
    ticket.save
    expect(Ticket.all.length).to match(0)

    ticket.project = project
    ticket.save
    expect(Ticket.all.length).to match(1)
    expect(Ticket.first.project_id).to match(project.id)
    
    description = "Test project 1 description edited"
    ticket.project.description = description
    project.save
    expect(Project.first.description).to match (description)
    
    expect(Project.all.length).to match(1)
    expect(Ticket.all.length).to match(1)
    project.destroy
    expect(Project.all.length).to match(0)
    expect(Ticket.all.length).to match(0) 
  end
end

