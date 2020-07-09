require 'spec_helper'
require "rails_helper"

RSpec.describe Ticket, type: :model  do
  it "CRUD Ticket" do
    project = Project.new(name: "Test project 1", description: "Test project 1 description")
    project.save
    ticket = Ticket.new(name: "Test ticket 1", body: "Test ticket 1 under Test project 1", status: "new")
    ticket.save
    expect(Ticket.all.length).to match(0) # since ticket doesn't have project_id, invalid and not saved

    ticket.project = project
    ticket.save # saved this time
    expect(Ticket.all.length).to match(1)
    expect(Ticket.first.project_id).to match(project.id)
    
    # update project
    description = "Test project 1 description edited"
    ticket.project.description = description
    project.save
    expect(Project.first.description).to match(description)

    # update ticket
    ticket_body = "Test ticket 1 under Test project 1 Edited"
    ticket.body = ticket_body
    ticket.save
    expect(Ticket.first.body).to match(ticket_body)
    
    # delete project and ticket (project delete also cascades to tickets_
    expect(Project.all.length).to match(1)
    expect(Ticket.all.length).to match(1)
    project.destroy
    expect(Project.all.length).to match(0)
    expect(Ticket.all.length).to match(0) 
  end
end
