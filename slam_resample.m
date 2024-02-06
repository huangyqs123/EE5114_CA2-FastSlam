function [particles] = slam_resample(particles, init_weight)
	
	particles_count = size(particles, 2);
	weight_total = 0;
	%Step1
    for i = 1:particles_count
		weight_total = weight_total + particles(i).weight;
    end

    new_particles = repmat(struct('x', 0, 'y', 0, 'theta', 0, 'weight', 0, 'crnr_mem_blocks_count', 0, 'crnr_indiv_compat', 0, 'known_corners_count', 0, 'corners', []), 1, particles_count);

	for i = 1:particles_count
        % Missing codes start here
        
        % Resamples particles based on their weights
 
        %Step2: Generate a random number W' between 0 and W
        w_random = rand() * weight_total;

        %Step3: Deduct W by wt[1], wt[2], wt[3], … , wt[i] one by one until the result hits W'
        total_weight = 0;
        j = 1;
        while total_weight < w_random && j <= particles_count
            wt = particles(j).weight;

            if (total_weight + wt) >= w_random
                break; % Exit the loop when the result hits W'
            else
                total_weight = total_weight + wt;
                j = j + 1;
            end
        end

        % Step 4: Particle i in the old set will be chosen as one element in the new set
        new_particles(i) = particles(j); 
        % Afterwards, Each new particle should be given the same init_weight
        new_particles(i).weight = init_weight;
        % Missing codes end here
    end
    particles = new_particles;
end