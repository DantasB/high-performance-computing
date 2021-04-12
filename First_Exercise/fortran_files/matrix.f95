program matrix_vector
    implicit none

    !Variable declaration
    character(len=32) :: arg
    integer :: size, func
    real(8) :: start, finish
    real(8), dimension(:,:), allocatable :: matrix
    real(8), dimension (:), allocatable :: vector
    real(8), dimension (:), allocatable :: result

    !Getting argv unique argument (size) and casting it to integer
    call getarg(1, arg)    
    read(arg, "(I10)") size

    !Check which function will run 
    call getarg(2, arg)    
    read(arg, "(I1)") func

    !Allocating variables
    allocate(matrix(size, size))
    allocate(vector(size))
    allocate(result(size))

    call random_seed()

    call generate_random_vector(vector, size)
    call generate_random_matrix(matrix, size)

    if (func == 1) then
        call cpu_time(start) 
        call matrix_vector_product_ij(vector, matrix, result, size)
        call cpu_time(finish) 
    else if (func == 0) then
        call cpu_time(start) 
        call matrix_vector_product_ji(vector, matrix, result, size)
        call cpu_time(finish) 
    else
        CALL EXIT(0)
    end if

    !Deallocating variables
    deallocate(matrix)
    deallocate(vector)
    deallocate(result)

    print *, size, ";", (finish - start)

    contains

    subroutine generate_random_vector(vector, size)
        implicit none

        real(8), dimension(:) :: vector
        integer :: size, i
        real(8) :: number
        do i = 1, size
            call random_number(number)
            vector(i) = number * (size + 1)
        end do 
    end

    subroutine generate_random_matrix(matrix, size)
        implicit none

        real(8), dimension(:,:) :: matrix
        integer :: size, i, j
        real(8) :: number

        do i = 1, size
            do j = 1, size
                call random_number(number)
                matrix(i, j) = number * (size + 1)
            end do
        end do 
    end

    subroutine generate_vector_zero(vector, size)
        implicit none

        real(8), dimension(:) :: vector
        integer :: size, i
        real(8) :: number
        do i = 1, size
            call random_number(number)
            vector(i) = 0
        end do 
    end

    subroutine matrix_vector_product_ji (vector, matrix, result, size)
        implicit none

        real(8), dimension (:) :: vector
        real(8), dimension (:, :) :: matrix
        real(8), dimension (:) :: result
        integer :: i, j, size

        call generate_vector_zero(result, size)

        do j =1, size
            do i=1, size
                result(i) = result(i) +  matrix(i, j) * vector(j);
            end do
        end do
    end

    subroutine matrix_vector_product_ij (vector, matrix, result, size)
        implicit none

        real(8), dimension (:) :: vector
        real(8), dimension (:, :) :: matrix
        real(8), dimension (:) :: result
        integer :: i, j, size

        call generate_vector_zero(result, size)

        do i=1, size
            do j=1, size
                result(i) = result(i) +  matrix(i, j) * vector(j);
            end do
        end do
    end

end program matrix_vector