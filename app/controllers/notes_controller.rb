class NotesController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]
before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = Note.all
    @notes = policy_scope(Note).order(created_at: :desc)
    @current_user = current_user
    @ycourses = Ycourse.all

  end

  def show
    authorize @note
  end

  def new
    @note = Note.new
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
    params.require(:note).permit(:title)
  end

  def set_note
    @note = Note.find(params[:id])
  end
end
