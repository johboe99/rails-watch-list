class BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
    @list = List.find(params[:list_id])
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:bookmark][:movie])
    @bookmark.list = @list # sets the list_id
    @bookmark.movie = @movie # sets the movie_id
    if @bookmark.save
      # YAYYY it worked
      redirect_to list_path(@list)
    else
      # NOOOO there were some errors, validation or whatever
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end
end
