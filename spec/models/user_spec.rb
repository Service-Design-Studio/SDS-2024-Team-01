require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    # Include the necessary helpers for URL generation
    extend ActionDispatch::Routing::UrlFor
    extend Rails.application.routes.url_helpers
  end
  subject do
    create(:random_user)
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a number' do
    subject.number = nil
    expect(subject).to_not be_valid
  end

  it 'is valid without a number for non normal users' do
    subject.number = nil
    subject.role_id = 4
    expect(subject).to be_valid
  end

  it 'is not valid with a used number' do
    expect do
      create(:random_user, number: subject.number)
    end.to raise_error(ActiveRecord::RecordNotUnique)
  end

  it 'is not valid without an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with a non SG number' do
    subject.number = '1234567'
    expect(subject).to_not be_valid
  end
end
