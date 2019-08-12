require "./lib/converter.rb"

describe Converter do
    include Converter

    context "#coord_functions" do
        it "coord move" do
            expect(coord_move([0,0], 2, 3)).to eql([2,3])
        end
        it "coord to string" do
            expect(coord_to_string([[2,3],[3,4]])).to eql(["c4", "d5"])
        end
        it "string to coord" do
            expect(string_to_coord("d5")).to eql([3,4])
        end
    end
end