class Parola < ActiveRecord::Base
  
  before_save :convert
  validates_uniqueness_of :input
 
  def has_definition?
    !self.definition.nil? and self.definition != ""
  end
  
  def convert
    self.output = self.input.downcase
    
    
    #### ENDINGS
    
    # get rid of that vowel ending first
    if !!(self.output[self.output.length-2] =~ /[aeiou]/ and self.output[self.output.length-1] =~ /[aeiou]/)
      self.output = self.output[0..self.output.length-3]
    elsif !!(self.output[self.output.length-1] =~ /[aeiou]/)
      self.output = self.output[0..self.output.length-2]
    end
        
    #drop the ending vowel of a word in a phrase if the next word starts with vowel
    split_array = self.output.split(" ")
    if split_array.size > 1
      split_array[0..split_array.length-2].each do |word|
        new_word = word
        if !!(split_array[split_array.index(word) + 1][0] =~ /[aeiou]/)
          if !!(word[word.length-2] =~ /[aeiou]/ and word[word.length-1] =~ /[aeiou]/)
            new_word = word[0..word.length-3]
          elsif !!(word[word.length-1] =~ /[aeiou]/)
            new_word = word[0..word.length-2]
          end
          
          #if a word originally ended in r-vowel or SINGLE t-vowel, make it hard (calamari -> calamad, scostumato -> scustumad)
          if split_array[split_array.index(word)][word.length-2] == "r" or 
            (split_array[split_array.index(word)][word.length-2] == "t" and split_array[split_array.index(word)][word.length-3] != "t")
            new_word[word.length-1] = "d"    
          # if a word ends in iolo, drop the o and make it iul (mariolo -> mariul')
          elsif !!(split_array[split_array.index(word)][word.length-2] =~ /[o]/) and 
            (split_array[split_array.index(word)][word.length-4..word.length-2] == "iol")
            new_word[word.length-2] = "u"
          elsif split_array[split_array.index(word)][word.length-3..word.length-2] == "ci" or 
            split_array[split_array.index(word)][word.length-3..word.length-2] == "ci"
            new_word[word.length-2..word.length-1] = "ch"
          elsif split_array[split_array.index(word)][word.length-3..word.length-2] == "zz"
            new_word[word.length-2..word.length-1] = "tz"
          elsif split_array[split_array.index(word)][word.length-3..word.length-2] == "gl"
            new_word[0..word.length-2] + "l"
          end
          
          
        end


        puts new_word
        split_array[split_array.index(word)] = new_word
      
      end
    end
    
    self.output = split_array.join("")
    
    #if a word originally ended in r-vowel or SINGLE t-vowel, make it hard (calamari -> calamad, scostumato -> scustumad)
    if self.input[self.input.length-2] == "r" or 
      (self.input[self.input.length-2] == "t" and self.input[self.input.length-3] != "t")
      self.output[self.output.length-1] = "d"
    elsif self.input[self.input.length-2] == "p"
      if self.input[self.input.length-3] != "p"
        self.output[self.output.length-1] = "b"
      else
        self.output = self.output[0..self.output.length-2]
      end
    # if a word ends in iolo, drop the o and make it iul (mariolo -> mariul')
    elsif !!(self.input[self.input.length-1] =~ /[o]/) and (self.input[self.input.length-4..self.input.length-2] == "iol")
      self.output[self.output.length-2] = "u"
    elsif self.input[self.input.length-2..self.input.length-1] == "ci" or self.input[self.input.length-3..self.input.length-2] == "ci"
      self.output[self.output.length-2..self.output.length-1] = "ch"
    elsif self.output[self.output.length-2..self.output.length-1] == "zz"
      self.output[self.output.length-2..self.output.length-1] = "tz"
    elsif self.output[self.output.length-2..self.output.length-1] == "gl"
      self.output = self.output[0..self.output.length-3] + "l"
    elsif self.output[self.output.length-4..self.output.length-1] == "tell"
      self.output[self.output.length-4] = "d"
    end
    
    

    #### BEGINNINGS
    # if co appears at the beginning of a word, make it gu (coppino -> guppin')
    if !!(self.input[0..1] =~ /c[aou]/)
      self.output[0] = "g"
      if self.input[1] == "o"
        self.output[1] = "u"
      end
    elsif self.input[0..1] == "so" # if s*o appears at beginning of word, make it s*u (stonato -> stunad)
      self.output[1] = "u"
    elsif !!(self.input[0..2] =~ /[s][^f][o]/)
      self.output[2] = "u"
    elsif self.input[0..1] == "pu"
      self.output[0] = "b"
    elsif !!(self.input[0..2] =~ /[gc]iu/)
      self.output[0..2] = "joo"
    elsif self.input[0..1] == "ci"
      self.output[0] = "g"
    elsif self.input[0..3] == "mozz"
      self.output[0..1] = "mu"
    end
    
    
    ### MIDDLES
    self.output.gsub!("cil", "gil")
    self.output.gsub!("cci", "gi")   
    self.output.gsub!("scia", "sha")    
    self.output.gsub!(/([c][o])/, 'co' => 'go')
    
    
    # make it all one word
    self.output.gsub!(" ", "")
    
    if !!(self.output[self.output.length-1] =~ /[lmnt]/)
      self.output += "'"
    end
    
    return self.output
    
  end # end convert
  
end
