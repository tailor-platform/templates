import { Entity, PrimaryGeneratedColumn, Column } from "typeorm"

@Entity('User')
export class User {

    @PrimaryGeneratedColumn('uuid')
    id!: string

    @Column({ type: 'text' })
    name!: string

    @Column({ type: 'text' })
    email!: string

}
