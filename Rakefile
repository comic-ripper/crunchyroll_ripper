require "bundler/gem_tasks"

require 'pry'
require 'dotenv'
Dotenv.load

require 'filemagic/ext'
require 'pathname'

require 'crunchyroll_ripper'

task :test do
  outdir = Pathname.new(".") + 'out'
  comic = CrunchyrollRipper::Comic.new series_id: 197
  comic.chapters.each do |chapter|
    chapt_dir = outdir + "ch.#{chapter.number}"
    `mkdir -p #{chapt_dir.to_s}`
    chapter.pages.each do |page|
      case page.image.mime_type
      when "image/jpeg; charset=binary"
        File.open(chapt_dir + "#{page.number}.jpg", "wb+") do |f|
          puts f.filename, f.write page.image
        end
      else
        binding.pry
        raise "Unknown image type #{page.image.mime_type}"
      end
    end
  end
end
