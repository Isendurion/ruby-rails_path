require 'spec_helper'

describe WorkWithFile do
  describe '#export' do
    it 'creates new file' do
      work_with_file = WorkWithFile.new
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      allow(File).to receive(:new)
      work_with_file.export(peugeot207)
      expect(File).to have_received(:new).with('Peugeot_207.txt', 'w')
      File.delete('Peugeot_207.txt')
    end

    it 'creates new file only if it does not exist' do
      work_with_file = WorkWithFile.new
      peugeot207 = Car.new(name: 'Peugeot 207', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      work_with_file.export(peugeot207)
      expect{
        work_with_file.export(peugeot207)
      }.to raise_error WorkWithFile::FileExistsError, 'File with this name already exists. Change name'
      File.delete('Peugeot_207.txt')
    end

    it 'gives car name as a name to the file' do
      work_with_file = WorkWithFile.new
      strzala = Car.new(name: 'Strzala', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      allow(File).to receive(:new)
      work_with_file.export(strzala)
      expect(File).to have_received(:new).with('Strzala.txt', 'w')
      File.delete('Strzala.txt')
    end

    it 'saves car properties to the file' do
      work_with_file = WorkWithFile.new
      zaba = Car.new(name: 'Zaba', brand: 'Peugeot', model: '207', driver: Person.new(name: 'Jake'))
      allow(File).to receive(:write)
      work_with_file.export(zaba)
      expect(File).to have_received(:write).with('Zaba.txt', "Name: Zaba\nBrand: Peugeot\nModel: 207\nTransmission: 5-speed\n")
      File.delete('Zaba.txt')
    end
  end
end
