module LookUp
  class LookUpResponse
    def initialize(result, original_args)
      @original_args = original_args
      @result = result
    end

    def body
      """
        Your look-up command: '#{@original_args.join(' ')}'\n
        #{result_summary}\n
        #{result_body}
      """
    end

    private

    def result_summary
      @result.summary
    end

    def result_body
      @result.body
    end
  end
end
