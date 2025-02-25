class SongsController < ApplicationController

    def show
        locate_song
    end

    def index
        @songs = Song.all
    end

    def new
        @song = Song.new
    end

    def create
        @song = Song.new(song_params)
        if @song.save
            redirect_to @song
        else
            render :new
        end
    end

    def edit
        locate_song
    end

    def update
        locate_song
        if @song.update(song_params)
            redirect_to @song
        else
            render :edit
        end
    end

    def destroy
        locate_song.destroy
        redirect_to songs_path
    end

    private

    def locate_song
        @song = Song.find(params[:id])
    end

    def song_params
        params.require(:song).permit(:title, :released, :release_year, :artist_name, :genre)
    end
end
