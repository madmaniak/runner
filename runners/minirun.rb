Browser = Watir::Browser.new :firefox

class Minirun < Runner

  title "Running a Rowlf Minirun"

  task "Creating a Minirun instance - if a minirun box isn't already available" do

    description "Use CloudFormation. There is a Rowlf CF template in the [lonelyplanet/cloudformation](https://github.com/lonelyplanet/cloudformation/blob/master/output/rowlf.json)"

    step "Go to the CloudFormation console on AWS" do
      check do
        false
      end
    end

    step "Click \"Create Stack\"" do
      check do
        true
      end
    end

    task "Subtask" do

      step "Another step" do
        puts "Another step from subtask!"
        check { true }
      end

    end

  end

end
