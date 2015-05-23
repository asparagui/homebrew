require 'cmd/tap' # for tap_args

module Homebrew
  def untap
    raise "Usage is `brew untap <tap-name>`" if ARGV.empty?

    ARGV.each do |tapname|
      user, repo = tap_args(tapname)

      # we consistently downcase in tap to ensure we are not bitten by case-insensive
      # filesystem issues. Which is the default on mac. The problem being the
      # filesystem cares, but our regexps don't. So unless we resolve *every* path
      # we will get bitten.
      user.downcase!
      repo.downcase!

      tapd = HOMEBREW_LIBRARY/"Taps/#{user}/homebrew-#{repo}"

      raise "No such tap!" unless tapd.directory?
      puts "Untapping #{tapname}... (#{tapd.abv})"

      t = HOMEBREW_LIBRARY.to_s + "/LinkedTaps/??.#{user}.#{repo}"
      linked_tapd = Pathname.glob(t)[0]  # What!?
      
      if !linked_tapd.nil?
        linked_tapd.delete
        
        puts linked_tapd
        tapd.rmtree
        tapd.dirname.rmdir_if_possible
        
      else
        # Old style taps
        files = []
        tapd.find_formula { |file| files << file }
        unlink_tap_formula(files)
        
        puts "Untapped #{files.length} formula#{plural(files.length, 'e')}"
        
        tapd.rmtree
        tapd.dirname.rmdir_if_possible
      end
    end
  end

  def unlink_tap_formula paths
    untapped = 0
    gitignores = (HOMEBREW_LIBRARY/"Formula/.gitignore").read.split rescue []

    paths.each do |path|
      link = HOMEBREW_LIBRARY.join("Formula", path.basename)

      if link.symlink? && (!link.exist? || link.resolved_path == path)
        link.delete
        gitignores.delete(path.basename.to_s)
        untapped += 1
      end
    end

    HOMEBREW_REPOSITORY.join("Library/Formula/.gitignore").atomic_write(gitignores * "\n")

    untapped
  end
end
