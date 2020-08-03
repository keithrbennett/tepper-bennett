module SongHelper

def best_song_plays
  @best_song_plays ||= %w{
        red-roses.andy-wms
        red-roses.bert-kmft
        red-roses.dean-martin
        red-roses.sinatra
        red-roses.guy-lomb
        young-ones.clf-rich
        kiss-fire.louis-arm
        kiss-fire.geo-gibbs
        nty-lady.ames-bros
        n-for-xmas.b-gordon
        suzy-snow.r-clooney
        ww-young.andy-wms
        bagel-lox.rob-schneid
        run-back-me.n-wilson
        crush-ny.c-francis
        ssss-heart.ink-spots
        smr-sounds.r-goulet
        tr-light.h-hermits
        when-arms.c-francis
        jenny-kiss.ed-albert
        shop-arnd.elvis
        angel.elvis
        am-i-ready.elvis
        lady-loves.elvis
        puppet.elvis
        tear-rain.a-prysock
        kewpie-doll.p-como
        santa-daddy.b-gordon
        long-way.sinatra
        t-t-fingers.stargazers
    }.map { |code| SongPlay.find_by_code(code) }
end


def all_song_plays
  SongPlay.all
end

end
