Initialize this configuration
```
terraform init
```
Apply this configuration to create your S3 bucket and objects
```
terraform apply
```

Target the S3 bucket name
In main.tf, find the random_pet.bucket_name resource. The bucket module uses this resource to assign a randomized name to the S3 bucket. Update the value of length to 5.
Plan this change.
```
terraform plan
```

Plan the change again, but target only the random_pet.bucket_name resource.
```
terraform plan -target="random_pet.bucket_name"
```

Now create a plan that targets the module, which will apply to all resources within the module.
```
terraform plan -target="module.s3_bucket"
```

Apply the change to only the bucket name. 
```
terraform apply -target="random_pet.bucket_name"
```

Open outputs.tf and note that the bucket name output value references the random pet resource, instead of the bucket itself.
Update the bucket_name output to refer to the actual bucket name.
```
+ value       = module.s3_bucket.s3_bucket_id
```

Apply changes to the entire working directory to make Terraform update your infrastructure to match the current configuration, including the change you made to the bucket_name output. 
```
terraform apply
```

Target specific bucket objects
Open main.tf and update the contents of the bucket objects.
The example configuration uses a single line of example text to represent objects with useful data in them. 
```
-  content      = "Example object #${count.index}"
+  content      = "Bucket object #${count.index}"
```

You can pass multiple -target options to target several resources at once. Apply this change to two of the bucket object
```
terraform apply -target="aws_s3_object.objects[2]" -target="aws_s3_object.objects[3]"
```

Target bucket object names
Remove the prefix argument from the random_pet.object_names resource in main.tf.
```
-   prefix    = "learning"
```

Attempt to apply this change to a single bucket object.
```
terraform apply -target="aws_s3_object.objects[2]"
```

Destroy your infrastructure
```
terraform destroy -target="aws_s3_object.objects"
```
```
terraform destroy
```



