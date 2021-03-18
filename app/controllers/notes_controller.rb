class NotesController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]
before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = Note.all || "0"
    @notes = policy_scope(Note).order(created_at: :desc)
    @current_user = current_user
    @ycourses = Ycourse.all || "0"

    @ycourses_url = @ycourses.map do |ycourse|
      get_youtube_id(ycourse.url)
    end
    @fav_notes = FavouriteNote.all || "0"

    if params[:search].present?
      @search_notes = Note.where("content ILIKE ?", "%#{params[:search]}%")
      @search_ycourse = @search_notes.map do |ycourse|
        get_youtube_id(Ycourse.find(ycourse.ycourse_id).url)
      end
    else
      @search_notes = @notes
    end
  end

  def show
    authorize @note
    @ycourse = Ycourse.find(params[:id]) || "0"
    @ycourseID = get_youtube_id(@ycourse.url)
  end

  def new
    @note = Note.new
    @ycourse = Ycourse.new
    @note.ycourse = @ycourse
    authorize @note
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    authorize @note
    if @note.save
      redirect_to note_path(@note), notice: "A new Note has been created!"
    else
      render :new
    end
  end

  def edit
    authorize @note
  end

  def update
    authorize @note
    if @note.update(note_params)
      redirect_to @note, notice: 'Your Note was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    authorize @note
    @note.destroy
    redirect_to notes_url, notice: 'Your Note was successfully destroyed'
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end

  def set_note
    @note = Note.find(params[:id])
  end

  def get_youtube_id(url)
    url = url.gsub(/(>|<)/i, '').split(%r{(vi/|v=|/v/|youtu\.be/|/embed/)})
    return url if url[2].nil?

    id = url[2].split(/[^0-9a-z_\-]/i)
    id[0]
  end
end
