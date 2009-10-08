module ControllerExtensions    # for inclusion into ApplicationController

  def self.included(base)
    
    base.class_eval do
      helper_method :current_reader_session, :current_reader, :current_reader=
    end

    # returns a layout name for processing by radiant_layout
    # eg:
    # radiant_layout { |controller| controller.layout_for :forum }
    # will try these possibilities in order:
    #   current_site.forum_layout
    #   current_site.reader_layout
    #   Radiant::Config["forum.layout"]
    #   Radiant::Config["reader.layout"]
    #   a layout called 'Main'
    #   any layout it can find
  
    def layout_for(area = :reader)
      if defined? Site && current_site && current_site.respond_to?(:layout_for)
        current_site.layout_for(area)
      elsif area_layout = Radiant::Config["#{area}.layout"]
        area_layout
      elsif reader_layout = Radiant::Config["reader.layout"]
        reader_layout
      elsif main_layout = Layout.find_by_name('Main')
        "Main"
      elsif any_layout = Layout.find(:first)
        any_layout.name
      end
    end

  protected

    def current_reader_session
      return @current_reader_session if @current_reader_session.is_a?(ReaderSession)
      @current_reader_session = ReaderSession.find
      @current_reader_session
    end

    def current_reader_session=(reader_session)
      @current_reader_session = reader_session
    end

    def current_reader
      current_reader_session.record if current_reader_session
    end

    def current_reader=(reader)
      if reader && reader.is_a?(Reader)
        current_reader_session = ReaderSession.create!(reader)
      else
        current_reader_session.destroy
      end
    end

  end
end







