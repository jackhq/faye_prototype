require 'spec_helper'

describe Request do
  
  it { should be_true }
  
  it { should have_attribute(:sent_date) }
  it { should have_attribute(:confirmation_number) }
  it { should have_attribute(:received_date) }
  it { should have_attribute(:description) }
end
