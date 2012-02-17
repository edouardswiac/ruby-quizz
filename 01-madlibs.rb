#!/usr/bin/env ruby

stories ||= []
stories << "I had a ((an adjective)) sandwich for lunch today. It dripped all over my ((a body part)) and ((a noun))."
stories << "Our favorite language is ((a gemstone))."
stories << "Our favorite language is ((gem:a gemstone)). We think ((gem)) is better than ((a gemstone))."

# pick a random story
# extract tokens (()) from string
# if token has :, left element is pointer to token
# else token is pointer
class Story
  attr_reader :story, :tokens
  def initialize(story)
    @story = story
    @pointers = {}
    @tokens = story.scan(/\(\(([\s\w:]+)\)\)/).flatten
  end

  def map(token, value)
    if @pointers.has_key?(token)
        value = @pointers[token]
    elsif token.include?(":")
        token_split = token.split(":")
        @pointers[token_split[0]] = value
    end
    @story.sub!(/\(\(#{token}\)\)/, value.strip!)
  end
end

s = Story.new(stories.sample)

for token in s.tokens
  puts "- #{token} ?"
  s.map(token, gets)
end

puts "=> #{s.story}"