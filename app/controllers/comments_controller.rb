class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :approve]

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @blog = Blog.find(params[:blog_id])
    @entry = Entry.find(params[:entry_id])
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @blog = Blog.find(params[:blog_id])
    @entry = Entry.find(params[:entry_id])
    @comment = Comment.new(comment_params)
    @entry.comments << @comment

    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@blog, @entry], notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: [@blog, @entry] }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_entry_url(@blog, @entry), notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # APPROVE /entries/1
  # APPROVE /entries/1.json
  def approve
    respond_to do |format|
      if @comment.update(status: 'approved')
        format.html { redirect_to [@blog, @entry], notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: [@blog, @entry] }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @blog = Blog.find(params[:blog_id])
      @entry = Entry.find_by(blog_id: params[:blog_id], id: params[:entry_id])
      @comment = Comment.find_by(entry_id: params[:entry_id], id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :status)
    end
end
