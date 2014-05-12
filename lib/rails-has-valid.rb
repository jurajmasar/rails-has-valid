if defined?(ActiveRecord)
	module HasValid

		class InvalidColumnNameException < Exception;
		end

		def has_valid?(validated_attributes)
			#
			# Validate column names
			#
			raise ArgumentError unless validated_attributes.is_a?(Array) or validated_attributes.is_a?(Symbol)

			validated_attributes = [validated_attributes] if validated_attributes.is_a?(Symbol)

			validated_attributes = validated_attributes.map do |attribute|
				raise InvalidColumnNameException unless self.attribute_names.include?(attribute.to_s)
				attribute.to_sym
			end

			#
			# Duplicate object and run ActiveRecord validations
			#
			object = self.dup
			object.valid?

			#
			# Clear previous validation errors
			#
			errors.clear

			#
			# Add validation errors for validated_attributes
			#
			object.errors.to_h.each do |key, value|
				errors.add(key, value) if validated_attributes.include?(key)
			end

			errors.none?
		end

		def save_if_has_valid(validated_attributes)
			has_valid?(validated_attributes)

			self.save(validate: false) if errors.none?
			errors.none?
		end

		def save_if_has_valid!(validated_attributes)
			has_valid?(validated_attributes)

			if errors.none?
				self.save(validate: false)
			else
				raise ActiveRecord::RecordInvalid.new(self)
			end
		end

		def update_attributes_if_has_valid(attributes, validated_attributes)
			self.attributes = attributes
			save_if_has_valid(validated_attributes)
		end

		def update_attributes_if_has_valid!(attributes, validated_attributes)
			self.attributes = attributes
			save_if_has_valid!(validated_attributes)
		end

	end

	class ActiveRecord::Base
		include HasValid
	end
end