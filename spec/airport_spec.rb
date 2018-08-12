require 'airport'

describe Airport do
  let(:mockAeroplane) { double :aeroplane }

  before(:each) do
    @airport = Airport.new
  end

  it "has either stormy or clear weather" do
    expect(subject.weather).to eq("clear").or eq "stormy"
  end

  context "when .weather is clear" do
    before(:each) do
      @airport.weather = "clear"
    end

    describe "#land()" do
      it "stores planes in an airport" do
        expect(@airport.land(mockAeroplane)).to eq mockAeroplane
      end
    end

    describe "#take_off()" do
      it "clears a plane from the airport" do
        @airport.land(mockAeroplane)
        expect(@airport.take_off(mockAeroplane)).to eq nil
      end

      it "will not release planes that aren't in the airport" do
        expect { @airport.take_off("BA344") }.to raise_error "BA344 not in airport"
      end
    end

  end
  
  context "when .weather is 'stormy'" do
    before(:each) do
      @airport.weather = "stormy"
    end

    it "won't #land planes" do      
      expect { @airport.land(mockAeroplane) }.to raise_error "Stormy weather preventing landing"
    end

    it "won't #take_off planes" do
      @airport.plane = mockAeroplane
      expect { @airport.take_off(mockAeroplane) }.to raise_error "Stormy weather preventing take off"
    end

  end
end
