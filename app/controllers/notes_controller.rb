# require 'pry-byebug'

class NotesController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :tagged]
before_action :set_note, only: [:toggle_favorite, :show, :edit, :update, :destroy, :save_content]
protect_from_forgery except: :update

  def index
    @notes = Note.all || "0"
    @notes = policy_scope(Note).order(created_at: :desc)
    @current_user = current_user
    @ycourses = Ycourse.all || "0"

    @ycourses_url = @ycourses.map do |ycourse|
      get_youtube_id(ycourse.url)
    end

    if params[:search].present?
      @search_notes = Note.where("text_content ILIKE ?", "%#{params[:search]}%")
      @search_ycourse = @search_notes.map.with_index do |ycourse, index|
        get_youtube_id(Ycourse.find(@search_notes.find(@ycourses[index].id).id).url)
      end


    else
      @search_notes = @notes
    end
  end

  def show
    authorize @note
    @ycourse = Ycourse.find(params[:id]) || "0"
    @ycourseID = get_youtube_id(@ycourse.url)
    @related_notes = @note.find_related_tags
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

  def save_content
    authorize @note
    if @note.update(note_params)
      @note.text_content= JSON.parse(@note.json_content)
      @note.save


      respond_to do |format|
        format.json {render :show}
      end
    else
      render json: { error: "record has not been save, sorry!" }, status: 422
    end
  end

  def tagged
    if params[:tag].present?
      @notes = Note.tagged_with(params[:tag])
    else
      @notes = Note.all
    end
  end

  def destroy
    authorize @note
    @note.destroy
    redirect_to notes_url, notice: 'Your Note was successfully destroyed'
  end

  def toggle_favorite
    authorize @note
    if current_user.favorited?(@note)
      current_user.unfavorite(@note)
    else
      current_user.favorite(@note)
    end
    redirect_to note_path(@note), notice: "Note #{current_user.favorited?(@note) ? "added to" : "removed from"} favorites"
  end

  private

  def note_params
    params.require(:note).permit(:title, :json_content, :visible, tag_list: [])
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
