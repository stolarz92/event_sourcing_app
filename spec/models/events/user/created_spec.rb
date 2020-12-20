require 'rails_helper'

RSpec.describe Events::User::Created, type: :model do
  subject { Events::User::Created }

  describe 'class_methods' do
    describe '::payload_attributes' do
      it 'has valid attributes' do
        expect(subject.payload_attributes).to eq(["name", "email", "password"])
      end
    end

    describe 'aggregate_name' do
      it 'respond_to aggregate_name' do
        expect(subject.aggregate_name).to eq(:user)
      end
    end

    describe 'aggregate_reflections' do
      it 'respond_to aggregate_reflections' do
        expect(subject.aggregate_reflections).to eq({})
      end
    end
  end

  describe 'instance_methods' do
    let(:instance) { subject.new }

    let(:valid_payload) do
      {
        name: 'Test',
        email: 'email@test.com',
        password: 'password'
      }
    end

    it 'creates getter and setters' do
      expect(instance).to respond_to(:name)
      expect(instance).to respond_to(:email)
      expect(instance).to respond_to(:password)
    end

    describe '.apply' do
      let(:aggregate) do
        User.new
      end

      it 'assigns correct values and returns user' do
        expect(instance.apply(aggregate)).to eq(aggregate)
      end
    end
  end

  describe 'event creation' do
    let(:valid_payload) do
      {
        name: 'Test',
        email: 'email@test.com',
        password: 'password'
      }
    end

    context 'with valid payload' do
      it 'creates an event' do
        expect { subject.create(valid_payload) }
          .to change { Events::User::BaseEvent.count }.by(1)
          .and change { User.count }.by(1)
      end
    end
  end
end
