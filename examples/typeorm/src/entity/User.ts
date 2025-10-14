import { Entity, PrimaryGeneratedColumn, Column } from "typeorm"

@Entity('User')
export class User {

    @PrimaryGeneratedColumn('uuid')
    id!: string

    @Column({ type: 'varchar' })
    name!: string

    @Column({ type: 'varchar' })
    email!: string

}
