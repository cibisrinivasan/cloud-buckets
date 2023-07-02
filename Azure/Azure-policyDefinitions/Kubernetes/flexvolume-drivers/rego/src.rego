package k8sazureflexvolumes

violation[{"msg": msg, "details": {}}] {
    volume := input_flexvolumes[_]
    not input_flexvolumes_allowed(volume)
    msg := sprintf("FlexVolume %v is not allowed, pod: %v. Allowed drivers: %v", [volume, input.review.object.metadata.name, input.parameters.allowedFlexVolumeDrivers])
}

input_flexvolumes_allowed(volume) {
    input.parameters.allowedFlexVolumeDrivers[_] == volume.flexVolume.driver
}

input_flexvolumes[v] {
    v := input.review.object.spec.volumes[_]
    has_field(v, "flexVolume")
}

# has_field returns whether an object has a field
has_field(object, field) = true {
    object[field]
}
