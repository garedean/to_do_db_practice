require 'spec_helper'

describe(List) do

  describe(".all") do
    it("starts off with no lists") do
      expect(List.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      list = List.new(name: "epicodus stuff", id: nil)
      expect(list.name()).to(eq("epicodus stuff"))
    end
  end

  describe("#id") do
    it("sets the id when you save it") do
      list = List.new(name: "epicodus stuff", id: nil)
      list.save()
      expect(list.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save lists to database") do
      list = List.new(name: "epicodus stuff", id: nil)
      list.save()
      expect(List.all()).to(eq([list]))
    end
  end

  describe("#==") do
    it("is the same list it is has the same name") do
      list1 = List.new(name: "epicodus stuff", id: nil)
      list2 = List.new(name: "epicodus stuff", id: nil)
      expect(list1).to(eq(list2))
    end
  end

end
