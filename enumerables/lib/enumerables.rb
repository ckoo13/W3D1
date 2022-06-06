require "byebug"
class Array
    def my_each(&prc)
        i = 0

        while i < self.length
            prc.call(self[i])
            i += 1
        end

        self
    end

    def my_select(&prc)
        array = self.my_each(&prc)
        new_array = []
        i = 0
        while i < array.length
            if prc.call(array[i])
                new_array << array[i]
            end
            i += 1
        end
        new_array
    end

    def my_reject(&prc)
        array = self.my_each(&prc)
        new_array = []
        i = 0
        while i < array.length
            if !prc.call(array[i])
                new_array << array[i]
            end
            i += 1
        end
        new_array
    end

    def my_any?(&prc)
        array = self.my_each(&prc)
        i = 0
        while i < array.length
            if prc.call(array[i])
                return true
            end
            i += 1
        end
        false
    end

    def my_all?(&prc)
        array = self.my_each(&prc)
        i = 0
        while i < array.length
            if !prc.call(array[i])
                return false
            end
            i += 1
        end
        true
    end

    def my_flatten
        new_arr = []
        i = 0

        #base case: if arr is not an array => add to new_arr
        if !self.kind_of?(Array)
            new_arr.push(self)
        end

        #recursive step: iterate through the array -> if element is not an array => add to new_arr
            #if element is an array => call flatten and add that to our new_arr
        while i < self.length
            if !self[i].kind_of?(Array)
                new_arr.push(self[i])
            else
                new_arr += self[i].my_flatten
            end

            i += 1
        end

        new_arr
    end

    def my_zip(*args)
        i = 0
        answer = []
        first_hash = Hash.new { |h,k| h[k] = []}
        
        while i < self.length
            first_hash[i] << self[i]
            i += 1
        end
        #first_hash[0] = [1]
        #first_hash[1] = [2]
        #first_hash[2] = [3]

        #args = [[4,5,6], [7,8,9]]
        debugger
        (0...self.length).each do |i|
            args.my_each do |array|
                first_hash[i].push(array[i])
            end
        end

        first_hash.each_value do |val|
            answer << val
        end

        answer
    end

    def my_rotate(num=1)
        
        #positive
        i = 0
        while i < num
            self << self.shift()
            i += 1
        end

        #negative
        while i > num
            self.unshift(self.pop())
            i -= 1
        end

        self
    end

    def my_join(joiner="")
        new_str = ""
        self.my_each do |ele|
            if ele != self[-1] 
                new_str += ele + joiner
            else
                new_str  += ele
            end

        end
        new_str
    end

    def my_reverse
        i = self.length - 1
        answer = []
        while i >= 0
            answer << self[i]
            i -= 1
        end
        answer
    end
end

